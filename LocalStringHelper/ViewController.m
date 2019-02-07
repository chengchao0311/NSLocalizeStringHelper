//
//  ViewController.m
//  LocalStringHelper
//
//  Created by 陈 鑫琦 on 2019/2/5.
//  Copyright © 2019 cxq. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receviceSelectText:) name:@"com.helper.selectedText" object:nil];
    self.keyFeild.delegate = self;
    self.valueField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:nil];

}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    
    
}

- (void)receviceSelectText:(NSNotification*)textNotify{
    self.valueField.stringValue = textNotify.object;
       [self showResults:self.keyFeild.stringValue valueText:self.valueField.stringValue];
}


/**
 展示结果
 如果有一个字符串为空就不展示

 构建result String
 展示到result textfiled上
 
 @param keyText keyText
 @param valueText valueText
 */
- (void)showResults:(NSString*)keyText valueText:(NSString*)valueText {
    if (!keyText || [keyText isEqualToString:@""]) {
        self.resultField.stringValue = @"";
        return;
    }
    
    if (!valueText || [valueText isEqualToString:@""]) {
        self.resultField.stringValue = @"";
        return;
    }
    
    NSString * stringValue = [NSString stringWithFormat:@"\"%@\" = \"%@\"", self.keyFeild.stringValue, self.valueField.stringValue];
    self.resultField.stringValue = stringValue;
}





- (void)controlTextDidChange:(NSNotification *)notification {
    [self showResults:self.keyFeild.stringValue valueText:self.valueField.stringValue];
}


/**
 提交
 
 
 */
- (void)submit {
    
}

@end
