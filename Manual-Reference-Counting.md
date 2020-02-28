# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
     -----------
     
     
      NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

      NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""]; [punctuationSet release]; NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

      NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

      for (NSString *word in words) { NSNumber *count = wordFrequency[word]; if (count) { wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1]; } else { wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease]; } }

      printf("Word frequency: %s", wordFrequency.description.UTF8String); [wordFrequency release];
    
    
    
    -----------

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
    this is autorelased do to the use of a helper function
    
    
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
       this will not autorealese becaues we are calling "retain" on it 
    
    
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
    this will not autorelease cause we are calling initWithString on it 
    
    
	
	4. `NSDate *food = [NSDate new];`
    not autoreleased becaues we call new here 
    
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
    will not be autoreleased becaues we have just initalized the object 
    
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    this will autorelease cause  we are calling autorelease 

3. Explain when you need to use the `NSAutoreleasePool`.
it is used when you are dealing with many obects 


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

+(instancetype)personWithName:(NSString *)name;{
return [LSIPerson alloc] initWithName:name] autorelease];
}

@end
```
