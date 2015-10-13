//
//  APIClass.m
//  Leadoon
//
//  Created by Кирилл Ковыршин on 13.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "APIClass.h"

#define MAIN_URL @"http://leadoon.ru/ios/api.php"
#define API_KEY @"ZKtnQPTkWC7tYUKqfIeuHSIuuCHVVIlO1NjGsHukppsAa2sYQr168"

@implementation APIClass

//Запрос на сервер
-(void) getDataFromServerWithParams: (NSDictionary *) params method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack{
    
    NSString * url = [NSString stringWithFormat:@"%@?%@&api_key=%@",MAIN_URL,method,API_KEY];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    //Запрос
    [manager GET: url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Вызов блока
        compitionBack (responseObject);
        
        
        //Ошибки
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
