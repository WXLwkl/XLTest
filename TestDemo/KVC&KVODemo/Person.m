//
//  Person.m
//  KVC&KVODemo
//
//  Created by yinjia on 16/4/1.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "Person.h"

@implementation Person

-(NSString *)description
{
    return [NSString stringWithFormat:@"<%@:%p>,{name:%@,age:%@}",[self class],self,self.name,self.age];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"你正在为一个不存在的属性赋值");
}
-(id)valueForUndefinedKey:(NSString *)key {
    return @"这是一个不存在的属性";
}
@end
