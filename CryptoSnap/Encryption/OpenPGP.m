//
//  OpenPGP.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/4/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "OpenPGP.h"
#import "KBUser.h"
#import "KBPublicKey.h"
#import "KBPublicKeys.h"

#import "NSData+Base64.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface OpenPGP ()

@end

@implementation OpenPGP

+ (NSString *)encryptMessage:(NSString *)message
                      forKey:(NSString *)key
{
    __block NSString *result = nil;
    
    UIWebView *webView = [[UIWebView alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"openpgp" ofType:@"js"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *resultOfPGPLibEval = [webView stringByEvaluatingJavaScriptFromString:content];
    if ([resultOfPGPLibEval isEqualToString:@"true"]) {
        JSContext *context =  [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"]; // Undocumented access
        context[@"key"] = key;
        context[@"message"] = message;
        [context evaluateScript:@"var openpgp = window.openpgp; var publicKey = openpgp.key.readArmored(key);var pgpMessage = openpgp.encryptMessage(publicKey.keys, message);"];
        JSValue *val2 = context[@"pgpMessage"];
        result = val2.toString;
    }
    
    return result;
}

+ (NSString *)encryptMessageAndSign:(NSString *)message
                       forPublicKey:(NSString *)pubKey
                      andPrivateKey:(NSString *)pvtKey
{
    __block NSString *result = nil;
    
    UIWebView *webView = [[UIWebView alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"openpgp" ofType:@"js"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *resultOfPGPLibEval = [webView stringByEvaluatingJavaScriptFromString:content];
    if ([resultOfPGPLibEval isEqualToString:@"true"]) {
        JSContext *context =  [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"]; // Undocumented access
        context[@"pubKey"] = pubKey;
        context[@"pvtKey"] = pvtKey;
        context[@"message"] = message;
        [context evaluateScript:@"var openpgp = window.openpgp; var publicKey = openpgp.key.readArmored(pubKey); var privateKey = openpgp.key.read(pvtKey); var pgpMessage = openpgp.signAndEncryptMessage(publicKey.keys, privateKey.keys, message);"];
        JSValue *val2 = context[@"pgpMessage"];
        result = val2.toString;
    }
    
    return result;
}

+ (NSString *)decryptMessage:(NSString *)message
                      forKey:(NSString *)key
{
    __block NSString *result = nil;
    
    UIWebView *webView = [[UIWebView alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"openpgp" ofType:@"js"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *resultOfPGPLibEval = [webView stringByEvaluatingJavaScriptFromString:content];
    if ([resultOfPGPLibEval isEqualToString:@"true"]) {
        JSContext *context =  [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"]; // Undocumented access
        context[@"key"] = key;
        context[@"message"] = message;
        [context evaluateScript:@"var openpgp = window.openpgp; var publicKey = openpgp.key.readArmored(key);var pgpMessage = openpgp.decryptMessage(publicKey.keys, message);"];
        JSValue *val2 = context[@"pgpMessage"];
        result = val2.toString;
    }
    
    return result;
}

+ (NSString *)decryptMessageAndVerify:(NSString *)message
                         forPublicKey:(NSString *)pubKey
                        andPrivateKey:(NSString *)pvtKey
{
    __block NSString *result = nil;
    
    UIWebView *webView = [[UIWebView alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"openpgp" ofType:@"js"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *resultOfPGPLibEval = [webView stringByEvaluatingJavaScriptFromString:content];
    if ([resultOfPGPLibEval isEqualToString:@"true"]) {
        JSContext *context =  [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"]; // Undocumented access
        context[@"pubKey"] = pubKey;
        context[@"pvtKey"] = pvtKey;
        context[@"message"] = message;
        [context evaluateScript:@"var openpgp = window.openpgp; var publicKey = openpgp.key.readArmored(pubKey); var privateKey = openpgp.key.read(pvtKey); var pgpMessage = openpgp.decryptAndVerifyMessage(publicKey.keys, privateKey.keys, message);"];
        JSValue *val2 = context[@"pgpMessage"];
        result = val2.toString;
    }
    
    
    return result;
}

@end
