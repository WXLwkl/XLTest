//
//  Person.h
//  KVC&KVODemo
//
//  Created by yinjia on 16/4/1.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Book;

@interface Person : NSObject


@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *age;

@property (nonatomic,strong) Book *book;

@end
