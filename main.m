

#import <Foundation/Foundation.h>
#import "LinkedList.h"


void setRandomList(LinkedList*, int);
void testConstructors();
void reverseListTest();
void searchElementTest();


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        testConstructors();
        reverseListTest();
        searchElementTest();
        
        
    }
    printf("\n\n\n\n");
    return 0;
}


void setRandomList(LinkedList* inList, int numItems) {
    /* Intializes random number generator */
    time_t t;
    srand((unsigned) time(&t));
    
    for (int i = 1; i <= numItems; i++) {
        [inList attach:rand() % 50];
    }
}


void testConstructors() {
    printf("\n------------------------------------------------------");
    printf("--------------------------------------------------------\n\n");
    printf("1. Constructor & Copy Constructor Test\n");
    
    LinkedList* intList1 = [[LinkedList alloc]init];
    printf("\nNew empty instance of \"LinkedList\" called intList1\n");
    
    printf("Is Empty [0/1] : %d\n", [intList1 isEmptyList]);
    
    setRandomList(intList1, 5);
    printf("\n6 random integers added.\n");
    printf("numItmes = 5 [0/1]: %d\n", intList1.numItems == 5);
    
    
    LinkedList* intList2 = [[LinkedList alloc]init:intList1];
    printf("\nNew instance of \"LinkedList\" called intList2\n");
    printf("intList2 makes a deep copy intList1 using the copy constructor. \n");
    
    printf("intList2 is Empty [0/1] : %d\n", [intList1 isEmptyList]);
    printf("numItmes = 5 [0/1]: %d\n", intList2.numItems == 5);
    
    printf("\nDeleted two elements from the end of intList1\n");
    [intList1 popBack];
    [intList1 popBack];
    
    printf("\nTo ensure we have made a deep copy, we'll compare the memory adresses of the first two nodes.\n");
    printf("[intList1 front] == [intList2 front]: %d\n", intList1.headPtr == intList2.headPtr);
    
    if (intList1.headPtr != intList2.headPtr) {
        printf("Deep copy success!\n");
    }
    
    printf("\nPrint Lists\n");
    printf("intList1: ");
    [intList1 printList];
    printf("\n");
    printf("intList2: ");
    [intList2 printList];
    
    printf("\n\nTEST PASSED\n");
}


void reverseListTest() {
    printf("\nReverse List Test\n");
    
    LinkedList* testList = [[LinkedList alloc]init];
    setRandomList(testList, 10);
    
    printf("Original List: ");
    [testList printList];
    [testList reverse];
    printf("\n");
    printf("Reversed List: ");
    [testList printList];
    printf("\n");
    
}


void searchElementTest() {
    
    printf("\n\nValue Search Test\n");
    
    LinkedList* searchTestList = [[LinkedList alloc]init];
    
    [searchTestList attach:2];
    [searchTestList attach:4];
    [searchTestList attach:6];
    [searchTestList attach:8];
    [searchTestList attach:10];
    [searchTestList attach:12];
    
    printf("\nTarget List: ");
    [searchTestList printList];
    printf("\n");
    
    printf("\nSearch List for 6 \n");
    
    if ([searchTestList searchForValue:6]) {
        printf("Number 6 Found!\n");
    }
    else {
        printf("Not found!\n");
    }
    
    printf("\nSearch List for 3 \n");
    
    if ([searchTestList searchForValue:3]) {
        printf("Number 3 Found!");
    }
    else {
        printf("Not found!");
    }
    
}






