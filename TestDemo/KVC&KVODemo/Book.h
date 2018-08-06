//
//  Book.h
//  KVC&KVODemo
//
//  Created by yinjia on 16/4/1.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;
@interface Book : NSObject

@property (nonatomic,copy) NSString *bookname;
@property (nonatomic,strong) Person *p;
@end
