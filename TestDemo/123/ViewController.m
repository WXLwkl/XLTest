//
//  ViewController.m
//  123
//
//  Created by xingl on 16/7/28.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "Tools.h"
#import "Model.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (retain,nonatomic) NSArray *modelArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
//    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    
    self.table.rowHeight = 60;
    
    self.modelArr = [Tools getOriginalImages];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
    }
    
    Model *model = [self.modelArr objectAtIndex:indexPath.row];
    
    cell.imageView.image = model.Array.lastObject;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)model.Array.count];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Model *model = [self.modelArr objectAtIndex:indexPath.row];
    
    NextViewController *vc = [[NextViewController alloc] init];
    vc.arr = model.Array;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
