
#import <Foundation/Foundation.h>

@interface LinkedList : NSObject {
    
    struct Node {
        struct Node* previousNode;
        struct Node* nextNode;
        NSInteger data;
    };
    
}

@property (nonatomic) NSInteger numItems;
@property (nonatomic) struct Node* headPtr;
@property (nonatomic) struct Node* tailPtr;
@property (nonatomic) struct Node* currentNode;
@property (nonatomic) BOOL sortedAscending;
@property (nonatomic) BOOL sortedDescending;


// Constructors
- (id) init;
- (id) init:(const LinkedList*) otherList;


// Iterators
- (void) begin;
- (void) end;
- (void) advance;
- (void) retreat;


// Bolleans
- (BOOL) isEmptyList;
- (BOOL) isEmptyNode;


// Console
- (void) printList;
- (void) printList:(const struct Node*)nodePtr;
- (void) printCurrent;


// Modifiers
- (void) clear;
- (void) popBack;
- (void) popFront;
- (void) popCurrent;
- (void) attach:(const NSInteger) inData;
- (void) pushBack:(const NSInteger) inData;
- (void) pushFront:(const NSInteger) inData;
- (void) setFirstNode:(const NSInteger) inData;
- (void) attachBeforeCurrent:(const NSInteger) inData;
- (void) attachBefore:(struct Node*) nodePtr andInt:(const NSInteger) inData;


// Operations
- (void) reverse;
- (void) sortAscending;
- (void) sortDescending;
- (BOOL) searchForValue:(NSInteger) searchValue;
- (void) attachList:(const LinkedList*) otherList;

@end
