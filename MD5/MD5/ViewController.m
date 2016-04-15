//
//  ViewController.m
//  MD5
//
//  Created by lanou3g on 16/3/11.
//  Copyright © 2016年 fk. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonCrypto.h>

void LO_CryptoMD5(const void *data,CC_LONG length,unsigned char *result);

void LO_CryptoMD5(const void *data,CC_LONG length,unsigned char *result){
    CC_MD5_CTX MD5;
    CC_MD5_Init(&MD5);
    CC_MD5_Update(&MD5, data, length);
    CC_MD5_Final(result, &MD5);
 
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self C_MD5_action];
//    [self OC_MD5_action];
    [self file_MD5_action ];
}
-(void)C_MD5_action{
    //明文
    char *cStr = "lksdf";
    //创建加密(相当于指针)
    CC_MD5_CTX md5;
    //初始化摘要变量
    CC_MD5_Init(&md5);
    //开始获取摘要
    
    CC_MD5_Update(&md5, cStr, (CC_LONG)strlen(cStr));
#warning mark - md5加密结果
    /** 
        128个二进制位,16个字节,32个16进制数
     **/
    //准备存放加密结果的数组
    unsigned char result[16] = {0};
    //完成摘要
//    CC_MD5_Final(result, &md5);
    
    LO_CryptoMD5(cStr, (CC_LONG)strlen(cStr), result);//自己封装的方法
    CC_MD5(cStr,(CC_LONG)strlen(cStr), result);
    NSMutableString *mStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < 16; i++) {
        [mStr appendFormat:@"%02X",result[i]];
    }
    NSLog(@"%@",mStr);
}

-(void)OC_MD5_action{
    NSString *string = @"slkdfjaiojf";
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([string UTF8String], (CC_LONG)string.length, result);
    NSMutableString *mStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < 16; i++) {
        [mStr appendFormat:@"%02x",result[i]];
    }
    NSLog(@"%@",mStr);
    
}

-(void)file_MD5_action{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"ViewController" ofType:@".m"];
    //转码
    NSData *data = [NSData dataWithContentsOfFile:path];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    NSMutableString *mStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < 16; i++) {
        [mStr appendFormat:@"%02x",result[i]];
    }
    NSLog(@"%@",mStr);
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
