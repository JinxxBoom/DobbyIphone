#import <Foundation/Foundation.h>
#include <pthread.h>
#include "dobby/dobby.h" 
#include <mach-o/dyld.h> 
#include <string.h>     


void* get_image_base_address(const char* image_name) {
    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        const char* name = _dyld_get_image_name(i);
        
        if (strstr(name, image_name) != NULL) {
            return (void*)_dyld_get_image_vmaddr_slide(i);
        }
    }
    return NULL;
}


void *my_hook_setup_thread(void* arg) {

    void* unityFrameworkBase = get_image_base_address("UnityFramework");
    if (unityFrameworkBase == NULL) { 
        return NULL;
    }

    addr_t target_offset = 0x12345; 
    void* target_address = (void*)((uintptr_t)unityFrameworkBase + target_offset);

    DobbyHook(target_address, (void*)fake_MyUnityGameFunc, (void**)&orig_MyUnityGameFunc);

    return NULL; 
}


__attribute__((constructor))
void trigger_hook_setup() {
    pthread_t ptid;
    
    int ret = pthread_create(&ptid, NULL, my_hook_setup_thread, NULL); 

    if (ret == 0) {
        pthread_detach(ptid);
    }
}