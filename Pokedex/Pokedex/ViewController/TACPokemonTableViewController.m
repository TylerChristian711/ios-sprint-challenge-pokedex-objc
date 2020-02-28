//
//  TACPokemonTableViewController.m
//  Pokedex
//
//  Created by Lambda_School_Loaner_218 on 2/28/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

#import "TACPokemonTableViewController.h"
#import "TACPokemonDetailViewController.h"
#import "TACPokemonController.h"
#import "TACPokemon.h"

@interface TACPokemonTableViewController ()
@property (nonatomic) TACPokemonController * pokemonController;
@end

@implementation TACPokemonTableViewController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokemonController = [[TACPokemonController alloc] init];
    }
    return self;
}

static NSString * const reuseIdentifier = @"PokeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokemonController fetchPokemonWithPokemonAPI:^(NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"# pokemon fetched: %lu", [self.pokemonController getPokemons].count);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }

    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pokemonController getPokemons].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];

    cell.textLabel.text = [[self.pokemonController getPokemons][indexPath.row].name capitalizedString];

    return cell;
}


 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     TACPokemonDetailViewController *detailVC = [segue destinationViewController];
     if ([segue.identifier isEqualToString:@"ShowDetialViewSegue"]) {
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         detailVC.pokemonController = self.pokemonController;
         detailVC.pokemon = [self.pokemonController getPokemons][indexPath.row];
     }
 }


@end
