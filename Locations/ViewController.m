//
//  ViewController.m
//  Locations
//
//  Created by Pavel Pantus on 5/10/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

#import "ViewController.h"
#import "TContact.h"

@interface ViewController ()

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
    // Set the title.
    self.title = @"TContacts";
	
    // Set up the buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
    self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
															  target:self
																   action:@selector(addContacts)];

	self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
																	target:self
																	action:@selector(editAllItems)];
	
	self.changeOrderButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
																		   target:self
																		   action:@selector(reorder)];
	
	self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: self.addButton, self.editButton, self.changeOrderButton, nil];
	
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TContact" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"details.lastEvent" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"TContact"];
	
    self.fetchedResultsController.delegate = self;
	
	NSError *error;
	NSLog(@"Start fetching!");
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)viewDidUnload {
    self.addButton = nil;
}

- (void)loadView {
    [super loadView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            if (!((sectionIndex == 0) && ([self.tableView numberOfSections] == 1)))
                [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            if (!((sectionIndex == 0) && ([self.tableView numberOfSections] == 1) ))
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            break;
        case NSFetchedResultsChangeUpdate:
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		
        // Delete the managed object at the given index path.
        NSManagedObject *contactToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:contactToDelete];
		
        // Commit the change.
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            // Handle the error.
        }
    }
}

- (void)addContacts {
	NSLog(@"add Contacts start!");
	
	for (int i = 0; i < 1000; i++) {
		TContact *contact = (TContact *)[NSEntityDescription insertNewObjectForEntityForName:@"TContact" inManagedObjectContext:self.managedObjectContext];
		
		int randomId = arc4random() % 1000000;
		UAccountID* accId = [[UAccountID alloc] initWithInt:randomId];
		contact.identifier = accId;
		
		contact.name = [NSString stringWithFormat:@"%d", randomId];
		contact.avatarId = [contact.name copy];
		contact.email = [contact.name copy];
		contact.organizationId = [contact.avatarId copy];
		contact.accountType = [[UAccountType alloc] initWithString:@"normal"];
		contact.lastModified = [NSDate date];
		contact.isFavorite = [NSNumber numberWithBool:YES];
		contact.details = [[TContactDetails alloc] init];
		contact.details.pending = PendingConnect;
		contact.details.lastEvent = randomId;
	}
	
    NSLog(@"Saving Contacts start!");
	NSError *error = nil;
	if (![self.managedObjectContext save:&error]) {
		NSAssert(0, @"Can't save!");
	}
    NSLog(@"Saving Contacts end!");
	
	NSLog(@"add Contacts finished!");
}

- (void)editAllItems {
	NSLog(@"edit Contacts start!");
	
	for (TContact *contact in self.fetchedResultsController.fetchedObjects)
	{
		int randomId = arc4random() % 1000000;
		UAccountID* accId = [[UAccountID alloc] initWithInt:randomId];

		contact.identifier = accId;
		contact.name = [NSString stringWithFormat:@"%d", randomId];
	}
	
	NSError *error = nil;
	if (![self.managedObjectContext save:&error]) {
		NSAssert(0, @"Can't save!");
	}
	
	NSLog(@"edit Contacts finished!");
}

- (void)reorder {
	NSLog(@"Reorder Contacts start!");
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"details.lastEvent" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[self.fetchedResultsController.fetchRequest setSortDescriptors:sortDescriptors];
	
	NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
	
	[self.tableView reloadData];
	
	NSLog(@"Reorder Contacts finished!");
}

- (void)editSelectedItem {
	NSIndexPath* selectedRow = [self.tableView indexPathForSelectedRow];
	
	TContact* contact = (TContact *)[self.fetchedResultsController objectAtIndexPath:selectedRow];
	
	NSError *error = nil;
	if (![self.managedObjectContext save:&error]) {
		NSAssert(0, @"Can't save!");
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.fetchedResultsController.sections count];
//	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static int counter = 0;
	
    static NSString *CellIdentifier = @"Cell";
	
    // Dequeue or create a new cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
	
    TContact *contact = (TContact *)[self.fetchedResultsController objectAtIndexPath:indexPath];
	
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lld", contact.details.lastEvent];
	
	if (counter++ == 9) {
		NSLog(@"End updating ui!");
	}
	
    return cell;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

@end
