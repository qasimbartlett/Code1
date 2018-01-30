#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int n1, n2 ;

int Array[100];
int count ; 

// A Binary Tree Node
struct Node
{
    struct Node *left, *right;
    int key;
};


// Utility function to create a new tree Node
Node* CreateNewNode(int key)
{
    Node *temp = (Node * ) malloc (sizeof(Node));
    temp->key = key;
    temp->left = temp->right = NULL;
	// printf ("Creating Node; Key=%d=\n",key);
    return temp;
}


struct Node * KeysIn (struct Node *N)
{
	
	if (N == NULL) { return NULL;}
	
	if ((N->key == n1) || (N->key == n2)) { return N ; }
	
	Node * KeysInLeft  = KeysIn(N->left);
	Node * KeysInRight = KeysIn(N->right);
	
	if (KeysInLeft && KeysInRight)  { return N ;}
	else {
		
		if (KeysInLeft) { return KeysInLeft; }
		else                { return KeysInRight ; }
	}
	
}


bool  Path (Node *N)
{
	
	if (N== NULL)     { return false ;}
	
	printf ("Path::Node=%d=\n", N->key) ;
	if (N->key == n1) { return true  ;}
	
	if (Path(N->left) || Path(N->right)) { printf ("%d ", N->key) ; return true ;}
	else                                 { printf ("Path::SKipping Node=%d=\n", N->key) ; return false ;}
	
	
	
	
	
}

Node * LRD (Node * N)
{
	
	if (N==NULL) { 
		return NULL ;
	}
	
	LRD(N->left);
	LRD(N->right);
	printf ("%d ", N->key);

	
	
	
}


Node * LDR (Node * N)
{
	if (N==NULL) { return NULL ;}
	
	LDR(N->left);
	printf ("%d ", N->key);
	LDR(N->right);
	
	
	
}

Node * DLR (Node * N)
{
	if (N==NULL) { 
		int i ;
	                   
		printf ("Idrees #s seen so far are = ");
		for (i=0;i<count;i++) { printf("%d ", Array[i]);}
		printf("\n");
		count++;
		return NULL ;
	}

	Array[count++] = N->key ;
	
	
	// printf ("key=%d ; count=%d=\n", N->key,count);
	DLR(N->left);
	count--;
	DLR(N->right);
	count-- ;
	
	
}

void PrintStPath (Node *N)
{
	
	if (N == NULL) {  printf ("\n"); exit(1);};
	
	printf ("%d ", N->key);
	PrintStPath (N->left);
	
}


// Driver program to test above functions
int main()
{
    // Let us create binary tree given in the above example
    Node * root 				= CreateNewNode(1);

    root->left        			= CreateNewNode(2);
    root->right 				= CreateNewNode(8);
	
    root->left->left 			= CreateNewNode(4);
    root->left->right 			= CreateNewNode(5);
    root->right->left 			= CreateNewNode(-2);
    root->right->right 			= CreateNewNode(6);

    root->left->left->left 	    = CreateNewNode(-4);
    root->left->left->right 	= CreateNewNode(7);
    root->left->right->left 	= CreateNewNode(10);
    root->left->right->right 	= CreateNewNode(-1);
    root->right->left->left 	= CreateNewNode(15);
    root->right->left->right 	= CreateNewNode(-6);
    root->right->right->left 	= CreateNewNode(3);
    root->right->right->right 	= CreateNewNode(-5);

	root->left->left->left->left 	    = CreateNewNode(-7);
	
	
	
	n1 = 6;
	n2 = 7;
	count = 0 ;
	
	
	// PrintStPath (root);
	
	
	/* 
	LRD(root); printf ("\n\n");
	LDR(root);printf ("\n\n");
	*/
	DLR(root);
	
	
	exit(1);
	
	Node *Result ;
	
	Result = KeysIn(root);
	
	printf ("Result ; Key=%d=\n",Result->key);
	
	Path (root);
  
}

