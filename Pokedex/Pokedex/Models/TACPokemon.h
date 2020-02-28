//
//  TACPokemon.h
//  Pokedex
//
//  Created by Lambda_School_Loaner_218 on 2/28/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




@interface TACPokemon : NSObject

@property (nonatomic,copy,nonnull) NSString *name;

@property (nonatomic,copy,nonnull) NSURL *detailsURL;

@property (nonatomic, nonnull) NSMutableArray *abilities;

@property (nonatomic) int pokemonId;

@property (nonatomic, nonnull) UIImage *pokemonSprite;

-(instancetype _Nonnull)initWithDictionary:(nonnull NSDictionary *)dictionary;

-(void)pokemonDetailsWithDictionary:(nonnull NSDictionary *)dictionary;

@end


