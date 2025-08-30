# 🟢 Minimum Absolute Difference in BST (LeetCode 530)

## Problem Statement
Given the `root` of a Binary Search Tree (BST), return the **minimum absolute difference** between the values of any two different nodes in the tree.

🔗 [LeetCode Problem Link](https://leetcode.com/problems/minimum-absolute-difference-in-bst/)

---

## Approach

1. **Observation**:  
   - An inorder traversal of a BST gives the node values in **sorted order**.  
   - The minimum absolute difference will always be between **two consecutive nodes** in this sorted order.

2. **Steps**:  
   - Perform an inorder traversal.  
   - Keep track of the previously visited node (`prev`).  
   - Update the minimum difference using `abs(root->val - prev->val)` whenever possible.  

3. **Time Complexity**:  
   - **O(N)** → visiting each node once.  

4. **Space Complexity**:  
   - **O(H)** → recursion stack, where `H` is the tree height.  

---

## C++ Code

```cpp
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
 * };
 */
class Solution {
public:
    void solve(TreeNode* root, int &mini, TreeNode* &prev) {
        if (root == nullptr) return;

        solve(root->left, mini, prev);
        if (prev != nullptr) {
            mini = min(mini, abs(root->val - prev->val));
        }
        prev = root;
        solve(root->right, mini, prev);
    }

    int getMinimumDifference(TreeNode* root) {
        int mini = INT_MAX;
        TreeNode* prev = nullptr;

        solve(root, mini, prev);
        return mini;
    }
};

🌳 Range Sum of BST (LeetCode 938)
Problem Statement

Given the root node of a binary search tree and two integers low and high, return the sum of values of all nodes with a value in the inclusive range [low, high].

Approach

Use DFS recursion on the BST.

If node->val lies in [low, high], include it in the sum.

If node->val < low, search only in the right subtree.

If node->val > high, search only in the left subtree.

This way we skip unnecessary branches and optimize traversal.

Complexity

Time Complexity: O(n) in the worst case, but optimized because we prune branches.

Space Complexity: O(h) where h is tree height (recursion stack).

Code (C++)
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
 * };
 */
class Solution {
public:
    int solve(TreeNode* root, int low, int high) {
        if (root == nullptr) return 0;

        int cur = root->val;
        if (cur >= low && cur <= high) {
            return cur + solve(root->left, low, high) + solve(root->right, low, high);
        }

        if (cur < low) return solve(root->right, low, high);
        return solve(root->left, low, high);
    }

    int rangeSumBST(TreeNode* root, int low, int high) {
        return solve(root, low, high);
    }
};

:

🌳 501. Find Mode in Binary Search Tree
🔹 Problem Statement

Given the root of a Binary Search Tree (BST) (which may contain duplicates), return all the mode(s) in it.

A mode is the most frequently occurred element(s).

If multiple values occur with the same highest frequency, return them all in any order.

🔹 Intuition

Inorder traversal of BST gives elements in sorted order.

Since duplicates in a BST appear consecutively during inorder, we can:

Keep track of the current number (curNum).

Maintain frequency of the current streak (curFreq).

Track the highest frequency seen so far (maxFreq).

Update answer list (ans) when curFreq equals or exceeds maxFreq.

🔹 Approach

Perform inorder traversal.

For each node:

If root->val == curNum, increment frequency.

Otherwise reset frequency to 1 and update curNum.

Compare curFreq with maxFreq:

If greater, reset ans and update maxFreq.

If equal, append current value to ans.

Return ans.

🔹 Code (C++)
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
 * };
 */
class Solution {
public:
    int curNum = 0;     // current number being tracked
    int curFreq = 0;    // frequency of current number
    int maxFreq = 0;    // maximum frequency seen so far
    
    void solve(TreeNode* root, vector<int>& ans) {
        if (!root) return;

        solve(root->left, ans);

        // Process current node
        if (root->val == curNum) {
            curFreq++;
        } else {
            curFreq = 1;
            curNum = root->val;
        }

        if (curFreq > maxFreq) {
            maxFreq = curFreq;
            ans = {}; // clear previous modes
        }
        if (curFreq == maxFreq) {
            ans.push_back(root->val);
        }

        solve(root->right, ans);
    }

    vector<int> findMode(TreeNode* root) {
        vector<int> ans;
        solve(root, ans);
        return ans;
    }
};

🔹 Complexity Analysis

Time Complexity: O(N) → each node visited once.

Space Complexity: O(H) for recursion stack (H = height of tree).

LEETCODE-1038
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
 * };
 */
class Solution {
public:
  void solve(TreeNode* root, int &sum){
        if(!root)return;

        solve(root->right,sum);
        sum+=root->val;
        root->val=sum;

        solve(root->left,sum);
    }
    TreeNode* convertBST(TreeNode* root) {
         int sum=0;
        solve(root,sum);
        return root;
    }
};
