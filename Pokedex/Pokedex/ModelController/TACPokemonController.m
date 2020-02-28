//
//  TACPokemonController.m
//  Pokedex
//
//  Created by Lambda_School_Loaner_218 on 2/28/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

#import "TACPokemonController.h"
#import "Pokedex-Swift.h"


@interface TACPokemonController ()

@property (nonatomic) NSArray<TACPokemon *> *pokemons;

@end

@implementation TACPokemonController

-(void)fetchPokemonWithPokemonAPI:(void (^)(NSError *error))completion {
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<TACPokemon *> *pokemons, NSError *error) {
        if (error) {
    NSLog(@"something is wrong in controller");
            completion(error);
            return;
        } else {
            self.pokemons =  [[NSArray alloc] initWithArray:pokemons];
            completion(nil);
        }
    }];
}

-(void)fetchDetailsWithPokemonAPIForPokemon:(TACPokemon *)pokemon {
    [PokemonAPI.sharedController fillInDetailsFor:pokemon];
}

-(NSArray <TACPokemon *> *)getPokemons {
    NSLog(@"pokemon array: %@", self.pokemons);
    return self.pokemons;
}

@end
