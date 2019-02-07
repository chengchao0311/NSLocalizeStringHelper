//
//  AppDelegate.m
//  LocalStringHelper
//
//  Created by 陈 鑫琦 on 2019/2/5.
//  Copyright © 2019 cxq. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self systemMakeMeWithRequest:YES];
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskFlagsChanged handler: ^(NSEvent *event) {
        NSUInteger flags = [event modifierFlags] & NSEventModifierFlagDeviceIndependentFlagsMask;
        if(flags ==  NSEventModifierFlagControl + NSEventModifierFlagCommand + NSEventModifierFlagShift + NSEventModifierFlagOption){
            [self showSelection];
        }
    }];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (void)showSelection {
    AXUIElementRef systemWideElement = AXUIElementCreateSystemWide();
    AXUIElementRef focussedElement = NULL;
    AXError error = AXUIElementCopyAttributeValue(systemWideElement, kAXFocusedUIElementAttribute, (CFTypeRef *)&focussedElement);
    if (error != kAXErrorSuccess) {
        NSLog(@"Could not get focussed element");
    } else {
        AXValueRef selectedValue = NULL;
        AXUIElementCopyAttributeValue(focussedElement, kAXSelectedTextAttribute, (CFTypeRef *)&selectedValue);
        NSString * selectedText = (__bridge NSString *)(selectedValue);
        NSLog(@"selectedText = %@", selectedText);
        if (selectedText) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"com.helper.selectedText" object:selectedText];
        }
    }
    if (focussedElement != NULL) CFRelease(focussedElement);
    CFRelease(systemWideElement);
}

- (BOOL)systemMakeMeWithRequest:(BOOL)requestAuth {
    NSDictionary *options = @{(__bridge id)kAXTrustedCheckOptionPrompt: @NO};
    BOOL accessibilityEnabled = AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)options);
    if (!accessibilityEnabled && requestAuth) { //索取权限
        NSDictionary *options = @{(__bridge id)kAXTrustedCheckOptionPrompt: @YES};
        AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)options);//申请权限
//        NSAlert *alert = [[NSAlert alloc] init];
//        alert.messageText = @"权限提示"; //标题
//        alert.informativeText = @"抱歉!要使用辅助登录功能,必须开启系统的辅助功能!\n具体是在接下来弹出的授权对话框里,选择本程序为允许,然后重新点击登录即可!";
//        [alert beginSheetModalForWindow:NSApp.mainWindow completionHandler:^(NSModalResponse returnCode) {
//
//        }]; //模态方式运行
    }
    return accessibilityEnabled;
}

@end
