 //
//  ViewController.m
//  KVC&KVODemo
//
//  Created by yinjia on 16/3/31.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Book.h"
@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)dealloc {
    
    [self.textField removeObserver:self forKeyPath:@"text"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
/******************     KVC       *********************/
    
    Person *p1 = [[Person alloc] init];
    [p1 setValue:@"lin" forKey:@"name"];
    [p1 setValue:@"25" forKey:@"age"];
    
    Book *b1 = [[Book alloc] init];
    b1.bookname = @"iPhone";
    p1.book = b1;
    
    
    Person *p2 = [[Person alloc] init];
    [p2 setValue:@"li" forKey:@"name"];
    [p2 setValue:@"24" forKey:@"age"];
    Book *b2 = [[Book alloc] init];
    b2.bookname = @"ios";
    p2.book = b2;
    
    
    NSLog(@"--%@-->%@",p1,[p2 valueForKey:@"name"]);
    
    NSArray *persons = @[p1,p2];
    NSLog(@"%@",persons);
    
    NSMutableArray *arrayM = [NSMutableArray array];
//    for (Person *p in persons) {
//        [arrayM addObject:[p valueForKeyPath:@"name"]];
//    }
//    [arrayM addObject:[persons valueForKeyPath:@"name"]];
//    
    [arrayM addObject:[persons valueForKeyPath:@"book.bookname"]];
    
//    arrayM = [persons valueForKeyPath:@"book.bookname"];
    
    
    NSLog(@"--%@",arrayM);
    
    
    [p2 setValue:@"ppp" forKeyPath:@"bookname"];
    
    NSLog(@"-33--%@",[p2 valueForKeyPath:@"bookname"]);
    
    
    
/******************     KVO       *********************/
    self.label.text = @"abc";
    
//    self.textField.text = self.str;
    
    [self.textField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew |
     NSKeyValueObservingOptionOld context:nil];
    
}








- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
//    if ([string isEqualToString:@""]) {
//        return YES;
//    } else {
//        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
//        return NO;
//    }
    
    
    NSString *str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    
    NSLog(@"/******** %lu,%lu  **********/",range.location,range.length);
    
    NSUInteger a = range.location - range.length;
    
    if (a == 5) {
        self.label.text = @"hello world";
        NSLog(@"---6位了");
    } else {
        self.label.text = @"abc";
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)change {
    self.label.text = @"你好";
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"change=%@",change);
    if ([keyPath isEqualToString:@"text"])
    {
        self.label.text = change[@"new"];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
