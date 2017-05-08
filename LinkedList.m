
#import "LinkedList.h"

@implementation LinkedList

// Constructors

- (id) init {
    self = [super init];
    self.numItems = 0;
    self.headPtr = nil;
    self.tailPtr = nil;
    self.currentNode = nil;
    return self;
}


- (id) init:(const LinkedList*) otherList {
    self = [super init];
    [self attachList:otherList];
    return self;
}


// Iterators

- (void) begin {
    self.currentNode = self.headPtr;
}


- (void) end {
    self.currentNode = self.tailPtr;
}


- (void) advance {
    
    if (self.currentNode != self.tailPtr && self.currentNode != nil) {
        self.currentNode = self.currentNode->nextNode;
    }
    
}


- (void) retreat {
    self.currentNode = self.currentNode->previousNode;
}


// Bolleans

- (BOOL) isEmptyList {
    return self.numItems == 0;
}


- (BOOL) isEmptyNode {
    return self.currentNode == nil;
}


// Console

- (void) printList {
    if (!self.isEmptyList) {
        [self printList:self.headPtr];
    }
}


- (void) printList:(const struct Node *)nodePtr {
    
    printf("%li ",nodePtr->data);
    
    if (nodePtr->nextNode != nil) {
        [self printList:nodePtr->nextNode];
    }
    
}


- (void) printCurrent {
    printf("%li",(long)self.currentNode->data);
}


// Modifiers

- (void) clear {
    
    [self begin];
    
    while (self.numItems > 0) {
        self.currentNode->previousNode = nil;
        [self advance];
        self.numItems--;
    }
    
    self.headPtr = nil;
    self.tailPtr = nil;
    self.currentNode = nil;
    
}


- (void) popCurrent {
    
    if (self.isEmptyNode) {
        NSLog(@"Attempted to delete empty node");
    }
    else if (self.currentNode == self.headPtr) {
        self.headPtr->nextNode = self.headPtr;
        self.currentNode = self.headPtr;
    }
    else if (self.currentNode == self.tailPtr) {
        self.tailPtr->previousNode = self.tailPtr;
        self.currentNode = self.tailPtr;
    }
    else {
        self.currentNode = self.currentNode->previousNode;
        self.currentNode->nextNode = self.currentNode->nextNode->nextNode;
    }
    
    self.numItems--;
    
}


- (void) popBack {
    
    if (self.currentNode == self.tailPtr) {
        [self retreat];
    }
    
    self.tailPtr = self.tailPtr->previousNode;
    self.numItems--;
    
}


- (void) popFront {
    
    if (self.currentNode == self.headPtr) {
        [self advance];
    }
    
    self.headPtr = self.headPtr->nextNode;
    self.numItems--;
    
}


- (void) attach:(NSInteger) inData {
    
    if (self.numItems == 0) {
        [self setFirstNode:inData];
    }
    else {
        if (self.currentNode == self.headPtr && self.currentNode != nil) {
            [self pushFront:inData];
        }
        else if (self.currentNode == self.tailPtr && self.currentNode != nil) {
            [self pushBack:inData];
        }
        else {
            struct Node* newNode = malloc(sizeof(struct Node));
            newNode->data = inData;
            newNode->previousNode = self.currentNode;
            newNode->nextNode = self.currentNode->nextNode;
            
            self.currentNode->nextNode = newNode;
            self.currentNode = newNode;
            self.numItems++;
        }
    }
    
}


- (void) pushBack:(NSInteger) inData {
    
    struct Node* newNode = malloc(sizeof(struct Node));
    newNode->data = inData;
    newNode->previousNode = self.tailPtr;
    newNode->nextNode = nil;
    
    self.tailPtr->nextNode = newNode;
    self.tailPtr = newNode;
    self.currentNode = newNode;
    self.numItems++;
    
}


- (void) pushFront:(NSInteger) inData {
    
    struct Node* newNode = malloc(sizeof(struct Node));
    newNode->data = inData;
    newNode->previousNode = self.headPtr;
    newNode->nextNode = self.headPtr->nextNode;
    
    self.headPtr->nextNode = newNode;
    self.currentNode = newNode;
    self.numItems++;
    
    if (self.numItems == 2) {
        self.tailPtr = newNode;
    }
    
}


- (void) setFirstNode:(NSInteger) inData {
    
    struct Node* newNode = malloc(sizeof(struct Node));
    newNode->data = inData;
    newNode->previousNode = nil;
    newNode->nextNode = nil;
    
    self.headPtr = newNode;
    self.tailPtr = newNode;
    self.currentNode = newNode;
    self.numItems++;
    
}


- (void) attachBeforeCurrent:(const NSInteger)inData {
    [self attachBefore:self.currentNode andInt:inData];
}


- (void) attachBefore:(struct Node *)nodePtr andInt:(const NSInteger)inData {
    
    struct Node* newNode = malloc(sizeof(struct Node));
    newNode->data = inData;
    
    if (nodePtr == self.headPtr) {
        newNode->nextNode = self.headPtr;
        newNode->previousNode = nil;
        self.headPtr = newNode;
    }
    else if (nodePtr == self.tailPtr) {
        newNode->nextNode = self.tailPtr;
        newNode->previousNode = self.tailPtr->previousNode;
        self.tailPtr->previousNode->nextNode = newNode;
        self.tailPtr->previousNode = newNode;
    }
    else {
        newNode->nextNode = self.currentNode;
        newNode->previousNode = self.currentNode->previousNode;
        self.currentNode->previousNode = newNode;
    }
    
    self.currentNode = newNode;
    self.numItems++;
    
}


// Operations

- (void) reverse {
    
    NSInteger tempData;
    NSInteger count = 0;
    struct Node* iteratorFront = self.headPtr;
    struct Node* iteratorBack = self.tailPtr;
    
    while (count < self.numItems / 2) {
        tempData = iteratorFront->data;
        iteratorFront->data = iteratorBack->data;
        iteratorBack->data = tempData;
        
        iteratorFront = iteratorFront->nextNode;
        iteratorBack = iteratorBack->previousNode;
        count++;
    }
    
}


- (void) sortAscending {
    
    if (self.sortedDescending) {
        [self reverse];
        self.sortedDescending = false;
    }
    
    else {
        // Insertion
    }
    
    self.sortedAscending = true;
    
}


- (void) sortDescending {
    
    if (self.sortedAscending) {
        [self reverse];
        self.sortedAscending = false;
    }
    else {
        // Quick Sort
    }
    
    self.sortedDescending = true;
}


- (BOOL) searchForValue:(NSInteger) searchValue {
    
    struct Node* iterator = self.headPtr;
    
    while (iterator != self.tailPtr->nextNode) {
        
        if (iterator->data == searchValue) {
            return true;
        }
        
        iterator = iterator->nextNode;
    }
    
    return  false;
    
}


- (void) attachList:(const LinkedList*) otherList {
    
    struct Node* newNode = malloc(sizeof(struct Node));
    struct Node* iterator = otherList.headPtr;
    const NSInteger SIZE = self.numItems;
    
    if (otherList.numItems > 0) {
        
        if (![self isEmptyList]) {
            self.tailPtr->nextNode = otherList.headPtr;
        }
        
        while (self.numItems != otherList.numItems + SIZE) {
            
            if (iterator == otherList.headPtr && self.headPtr == nil) {
                self.headPtr = newNode;
            }
            if (iterator == otherList.tailPtr) {
                self.tailPtr = newNode;
            }
            
            newNode->data = iterator->data;
            newNode->nextNode = malloc(sizeof(struct Node));
            newNode->previousNode = newNode;
            newNode = newNode->nextNode;
            
            if (iterator->nextNode != nil) {
                iterator = iterator->nextNode;
            }
            
            self.numItems++;
            
        }
        
        self.currentNode = self.tailPtr;
    }
}

@end
