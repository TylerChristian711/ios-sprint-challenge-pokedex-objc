//
//  TACPokemonDetailViewController.m
//  Pokedex
//
//  Created by Lambda_School_Loaner_218 on 2/28/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

#import "TACPokemonDetailViewController.h"
#import "TACPokemonController.h"
#import "TACPokemon.h"

void *KVOContext = &KVOContext;

@interface TACPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation TACPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokemonController fetchDetailsWithPokemonAPIForPokemon:self.pokemon];
    [self updateViews];
}

- (void)updateViews {
    if(self.pokemon) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameLabel.text = [[NSString stringWithFormat:@"Name: %@",self.pokemon.name] capitalizedString];
            self.idLabel.text = [[NSString stringWithFormat:@"ID: %d", self.pokemon.pokemonId] capitalizedString];
            self.imageView.image = self.pokemon.pokemonSprite;
            NSString *abilityString = [[self.pokemon.abilities valueForKey:@"description"] componentsJoinedByString:@", "];
            self.abilitiesLabel.text = [[NSString stringWithFormat:@"Abilities: %@", abilityString] capitalizedString];
        });
    }
}

- (void)setPokemon:(TACPokemon *)pokemon {

    [_pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
    [_pokemon removeObserver:self forKeyPath:@"pokemonId" context:KVOContext];
    [_pokemon removeObserver:self forKeyPath:@"pokemonSprite" context:KVOContext];

    _pokemon = pokemon;

    [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionNew context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"pokemonId" options:NSKeyValueObservingOptionNew context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"pokemonSprite" options:NSKeyValueObservingOptionNew context:KVOContext];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        if([keyPath isEqualToString:@"abilities"]) {
            [self updateViews];
        } else if([keyPath isEqualToString:@"pokemonId"]) {
            [self updateViews];
        } else if([keyPath isEqualToString:@"pokemonSprite"]) {
            [self updateViews];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    self.pokemon = nil;
}

@end





