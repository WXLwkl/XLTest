//
//  MenuViewController.m
//  SplitViewController
//
//  Created by yinjia on 16/4/13.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (nonatomic,retain)NSArray *array;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = @[@"11",@"22",@"33",@"44",@"55",@"66",@"77",@"88",@"99",];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = view;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"这里是第%lu行",(long)indexPath.row+1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = self.array[indexPath.row];
    
    if ([self.Delegate respondsToSelector:@selector(setString:)]) {
        [self.Delegate setString:[NSString stringWithFormat:@"%d",indexPath.row+1]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    self.block(str);
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
