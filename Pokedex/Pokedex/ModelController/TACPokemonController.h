//
//  TACPokemonController.h
//  Pokedex
//
//  Created by Lambda_School_Loaner_218 on 2/28/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TACPokemon;

@interface TACPokemonController : NSObject

-(void)fetchPokemonWithPokemonAPI:(void (^)(NSError *error))completion;

-(void)fetchDetailsWithPokemonAPIForPokemon:(TACPokemon *)pokemon;

-(NSArray <TACPokemon *> *)getPokemons;


@end


