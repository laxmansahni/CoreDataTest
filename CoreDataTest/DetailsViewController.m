//
//  DetailsViewController.m
//  coreDataTest
//
//  Created by Cafex-Development on 07/12/15.
//  Copyright © 2015 Cafex-Development. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (nonatomic, weak) IBOutlet UILabel *ageLabel;
@property (nonatomic, weak) IBOutlet UILabel *firstLabel;
@property (nonatomic, weak) IBOutlet UILabel *lastLabel;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    // filter according to your age
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"age == 32"]];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
        
    } else {
        NSLog(@"%@", result);
        
        if (result.count > 0) {
            NSManagedObject *person = (NSManagedObject *)[result lastObject];
            
            
            _ageLabel.text = [NSString stringWithFormat:@"%@", [person valueForKey:@"age"]];
            _firstLabel.text = [person valueForKey:@"first"];
            _lastLabel.text = [person valueForKey:@"last"];
            
            [self.managedObjectContext deleteObject:person];
            
            NSError *deleteError = nil;
            
            if (![person.managedObjectContext save:&deleteError]) {
                NSLog(@"Unable to save managed object context.");
                NSLog(@"%@, %@", deleteError, deleteError.localizedDescription);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
