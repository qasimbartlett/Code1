#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <queue>
#include <algorithm>
using namespace std;



class Node
{
public:

	int data ;
	Node * Left;
	Node * Right ;

	
		 Node (int);
	
};

class Tree
{
	Node * root;

	public:
		 Tree (Node *);
		 Node * Insert (int, Node *);
		void Search  (int, Node *) ;
		void LevelOrderSearch(Node *);
		void FindMin(Node *);
		void Walk_DLR (Node *);
		int FindHeight(Node *);
		
};

 Node::Node(int da)
{
	data = da ;
	Left = NULL;
	Right = NULL ;
	printf ("Node::Node:  Constructed; da=%d=\n",da);

}





Tree::Tree (Node *Na)
{
	
		root = Na ;
		printf ("Tree::Tree:  Constructed; =\n");
}


// Create a Node; Set the Left to the newly created Node  or the Right to the newly created Node.
Node * Tree::Insert(int da1, Node *SubTreeNode)
{
	
		// Create Node to be inserted
		
		
		if (SubTreeNode == NULL)              { SubTreeNode = new Node(da1); }
		else if (da1 <= (*SubTreeNode).data ) {printf("Tree::Insert go left of  Node =%d=\n", (*SubTreeNode).data); (*SubTreeNode).Left  = Insert(da1,(*SubTreeNode).Left);}
		else                                  {printf("Tree::Insert go Right of Node =%d=\n", (*SubTreeNode).data); (*SubTreeNode).Right = Insert(da1,(*SubTreeNode).Right);}
		
		return SubTreeNode;
		
	
}


void Tree::Search (int Pa, Node *subTreNode)
{
	
	if (subTreNode == NULL)             {printf ("Tree::Search DID NOT found the pattern %d\n", Pa); }
	else if (Pa == (*subTreNode).data)  {printf ("Tree::Search Node data=%d=found the pattern %d; \n", Pa,(*subTreNode).data);  }
	else if (Pa <  (*subTreNode).data ) {printf ("Tree::Search Node data=%d=;pattern %d; going left;\n", (*subTreNode).data,Pa); Search(Pa,(*subTreNode).Left);}
	else                                {printf ("Tree::Search Node data=%d=;pattern %d; going Roght\n", (*subTreNode).data,Pa); Search(Pa,(*subTreNode).Right);}
}



void Tree::Walk_DLR (Node *subNode)
{
	
	if (subNode == NULL) { return ;}

	Walk_DLR(subNode->Left);	
	printf ("%d ",subNode->data);
	// Walk_DLR(subNode->Left);
	Walk_DLR(subNode->Right);
	
}


//   delete a node containinig data = datX
Node * Tree::DeleteNode(Node *Nd, int datX)
{
	Node * CurNode = Nd ;
	Node *RetNode ;
	
	if (Nd == NULL) { return ;}
	else {
		// if datX < CUrrent_Node => target data in left 
		if      (datX < CurNode->data) { curNode->Left  = DeleteNode(CurNode->Left,datX);}
		else if (datX > CurNode->data) { curNode->Right = DeleteNode(CurNode->Right,datX }
		// Found the target Node
		else {
			// No child nodes
			if ((CurNode->Left == NULL) && (CurNode->Right == NULL)) {
					delete (CurNode);
					return NULL;
			}
			// 1 child on right  ie left is NULL
			else if (CurNode->Left == NULL)  {
					RetNode = CurNode->Right;
					delete (CurNode);
					return RetNode;
			}
			// 1 child on left  ie right is NULL
			else if (CurNode->Right == NULL)  {
					RetNode = CurNode->Left;
					delete (CurNode);
					return RetNode;
			}
			
			// node has 2children nodes
			else {
				
				// Take Left Node;  find Max in it
				
			}
			
		}
		
	
	
}


void Tree::FindMin(Node *SubTreeN)
{
	
	Node *CurNode = SubTreeN ;
	
	if (CurNode == NULL) {
		printf ("Error. Tree is NULL\n");
	}
	// Min found
	if (CurNode->Left == NULL) {
		printf ("FindMin:: Min = %d=\n", CurNode->data);
	}
	
	else {
		FindMin(CurNode->Left);
	}
	
	
}




int Tree::FindHeight(Node *SubTreeN)
{
	
	Node *CurNode = SubTreeN ;
	
	if (CurNode == NULL) { return -1 ;}
	else {
		return (1 + max(FindHeight(CurNode->Left), FindHeight(CurNode->Right)) );
	}
}


void Tree::LevelOrderSearch(Node *PtrToNode)
{
	
	Node *CurrentNode ;
	
	queue <Node *>  Q ;
	
	
	if (CurrentNode == NULL) { return;}
	
	
	Q.push(PtrToNode);
	
	while (!Q.empty()) {
	
		// Read the front of the array
		CurrentNode = Q.front();
		// Remove the 
		Q.pop();
		// print data
		printf("%d ", CurrentNode->data);
		
		// Push left child and right child into Q
		if (CurrentNode->Left  != NULL) { Q.push(CurrentNode->Left); }
		if (CurrentNode->Right != NULL) {Q.push(CurrentNode->Right); }
		
	}
	
}


int main() {

	Node Root(10);
	Tree tree(&Root);
	
	printf("\n\nInserting 20\n");
	tree.Insert(20,&Root);   
	
	printf("\n\nInserting 40\n");
	tree.Insert(40,&Root);
		
	printf("\n\nInserting 22\n");
	tree.Insert(22,&Root);
	tree.Insert(34,&Root);
	tree.Insert(45,&Root);
	
	tree.Insert(4,&Root);
	tree.Insert(3,&Root);

	
	printf("\n\nSearcng for 22\n");
	tree.Search(22, &Root);
	
	// Tracerse the tree
	tree.LevelOrderSearch(&Root);
	
	
	printf("\n\nFinding the minimum ");
	tree.FindMin(&Root);
	
	
	printf("Tree traversal DLR\n");
	tree.Walk_DLR(&Root);
	// cout << "Root craeted\n";

}
