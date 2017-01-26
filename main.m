//
//  main.m
//  YubiKeyDetector
//
//  Created by Delfim Machado on 24/07/17.
//  Copyright © 2017 Delfim Machado. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <xpc/xpc.h>
#include <unistd.h>

BOOL debug = true;

void handleEvent() {
    xpc_set_event_stream_handler("com.apple.iokit.matching", NULL, ^(xpc_object_t event) {
      const char *name = xpc_dictionary_get_string(event, XPC_EVENT_KEY_NAME);

      uint64_t id = xpc_dictionary_get_uint64(event, "IOMatchLaunchServiceID");

        NSLog(@"Received event: %s: %llu", name, id);

        pid_t p = fork();
        int status;
        if (p == 0) {
            execl("/Users/dbcm/.usbexec/commands", "/Users/dbcm/.usbexec/commands", "-from_daemon", NULL);
            if (errno == ENOENT)
                _exit(-1);
            _exit(-2);
        }
        wait(&status);
        if (WIFEXITED(status)) {
            printf("exited, status=%d\n", WEXITSTATUS(status));
        } else if (WIFSIGNALED(status)) {
            printf("killed by signal %d\n", WTERMSIG(status));
        } else if (WIFSTOPPED(status)) {
            printf("stopped by signal %d\n", WSTOPSIG(status));
        } else if (WIFCONTINUED(status)) {
            printf("continued\n");
        }
        
        
        
    });
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        handleEvent();
        if(debug) {
            NSLog(@"Events Purger called!");
        }
    }
    return 0;
}
