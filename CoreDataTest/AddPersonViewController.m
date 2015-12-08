//
//  ViewController.m
//  coreDataTest
//
//  Created by Cafex-Development on 07/12/15.
//  Copyright © 2015 Cafex-Development. All rights reserved.
//

#import "AddPersonViewController.h"
#import "AppDelegate.h"
#import "DetailsViewController.h"

@interface AddPersonViewController ()
@property (nonatomic, weak) IBOutlet UITextField *ageTextField;
@property (nonatomic, weak) IBOutlet UITextField *firstTextField;
@property (nonatomic, weak) IBOutlet UITextField *lastTextField;
@end

@implementation AddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *sharedDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = sharedDelegate.managedObjectContext;
}

-(IBAction)save:(id)sender
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    NSManagedObject *newPerson = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    
    // Set First and Lats Name
    [newPerson setValue:_firstTextField.text forKey:@"first"];
    [newPerson setValue:_lastTextField.text forKey:@"last"];

    NSNumber *number = [NSNumber numberWithInt:[_ageTextField.text intValue]];
    [newPerson setValue:number forKey:@"age"];
    
    NSError *error = nil;
    
    if (![newPerson.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"segue from home screen");
    if([[segue identifier] isEqualToString:@"showDetails"]){
        DetailsViewController *vc = [segue destinationViewController];
        vc.managedObjectContext = self.managedObjectContext;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
