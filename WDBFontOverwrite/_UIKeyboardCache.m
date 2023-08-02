//
//  _UIKeyboardCache.m
//  WDBFontOverwrite
//
//  Created by Noah Little on 6/1/2023.
//

#import <Foundation/Foundation.h>
#import <dlfcn.h>
#import <objc/runtime.h>
#import "fun/vnode.h"
#import "_UIKeyboardCache.h"

@implementation _UIKeyboardCache

+ (void)purge {
//    void *handle = dlopen("/System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore", RTLD_NOW);
//    if (handle) {
//        NSObject *kbCache = [objc_getClass("UIKeyboardCache") performSelector:@selector(sharedInstance)];
//        [kbCache performSelector:@selector(purge)];
//    }
    NSString *mntPath = [NSString stringWithFormat:@"%@%@", NSHomeDirectory(), @"/Documents/mounted"];
    [[NSFileManager defaultManager] removeItemAtPath:mntPath error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:mntPath withIntermediateDirectories:NO attributes:nil error:nil];
    // funVnodeRedirectFolder(mntPath.UTF8String, "/System/Library"); //<- should NOT be work.
    uint64_t orig_to_v_data = funVnodeRedirectFolder(mntPath.UTF8String, "/var/mobile/Library/Caches/com.apple.keyboards"); //<- should be work.
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:mntPath error:NULL];
    NSLog(@"mntPath directory list: %@", dirs);
    remove([mntPath stringByAppendingString:@"/images"].UTF8String);
    remove([mntPath stringByAppendingString:@"/version"].UTF8String);
//    [[NSFileManager defaultManager] removeItemAtPath:mntPath error:nil];
    NSArray* newdirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:mntPath error:NULL];
    NSLog(@"mntPath directory list: %@", newdirs);
    funVnodeUnRedirectFolder(mntPath.UTF8String, orig_to_v_data);
}

@end
