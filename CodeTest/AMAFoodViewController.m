//
//  AMAFoodViewController.m
//  CodeTest
//
//  Created by Matheson Mawhinney on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import "AMAFoodViewController.h"
#import "AMAFoodDetailViewController.h"
#import "FoodDatabase.h"
#import "FoodInfo.h"

@interface AMAFoodViewController ()

@end

@implementation AMAFoodViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.foods = [[FoodDatabase database] foodList:self.fd_grp_id];
    self.title = @"Foods";
    NSLog(@"Food group: %d", self.fd_grp_id);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.foods count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    [[cell textLabel] setNumberOfLines:0]; // unlimited number of lines
    [[cell textLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    [[cell textLabel] setFont:[UIFont systemFontOfSize: 14.0]];
    
    FoodInfo *info = [self.foods objectAtIndex:indexPath.row];
    NSString *cellText = [info.name capitalizedString];
    cellText = [[self invertString:cellText] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    cell.textLabel.text = cellText;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // this method is called for each cell and returns height
    FoodInfo *info = [self.foods objectAtIndex:indexPath.row];
    NSString * text = [info.name capitalizedString];
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize: 14.0] forWidth:[tableView frame].size.width - 40.0 lineBreakMode:NSLineBreakByWordWrapping];
    // return either default height or height to fit the text
    return textSize.height < 44.0 ? 44.0 : textSize.height;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"didSelectFood");
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    FoodInfo *info = [self.foods objectAtIndex:indexPath.row];
//    NSLog(@"fd_id: %d", info.fd_id);
//    NSLog(@"food: %@", info.name);
//    
////    AMAFoodViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"foodsView"];
////    myController.fd_grp_id = info.fd_id;
////    [self.navigationController pushViewController: myController animated:YES];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRow");
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    FoodInfo *info = [self.foods objectAtIndex:indexPath.row];
    
    AMAFoodDetailViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    myController.title = info.name ;
    myController.fd_id = info.fd_id;
    myController.current = info;

    [self.navigationController pushViewController: myController animated:YES];
}

- (NSString*)invertString:(NSString *)string {
    NSArray *stringArray = [[NSArray alloc] init];
    stringArray = [string componentsSeparatedByString:@","];
    NSArray* reversedArray = [[stringArray reverseObjectEnumerator] allObjects];
    NSString * result = [[reversedArray valueForKey:@"description"] componentsJoinedByString:@" "];
    return result;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
