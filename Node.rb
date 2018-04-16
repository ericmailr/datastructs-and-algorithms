class Node
	

	def initialize(value)
		@value = value
	end

	def getValue()
		return @value
	end

	def setParent(node)
		@parent = node
	end

	def getParent()
		return @parent
	end

	def setLeftChild(node)
		@left = node
	end

	def setRightChild(node)
		@right = node
	end

	def getLeftChild()
		return @left
	end

	def getRightChild()
		return @right
	end

	def printNode()
		puts "Value: #{@value}, Parent: #{@parent.getValue if @parent}, Left Child: #{@left.getValue if @left}, Right Child: #{@right.getValue if @right}"
	end

	

end

class BTree
	@tree
	@root
	def build_tree(array)
		@tree = []
		@root = Node.new(array[0])
		@tree << @root
		
		array[1..-1].each do |i|
			temp_compare_node = @root
			node = Node.new(i)
			loop do	
				if i < temp_compare_node.getValue
					if temp_compare_node.getLeftChild != nil
						temp_compare_node = temp_compare_node.getLeftChild
					else
						temp_compare_node.setLeftChild(node)
						node.setParent(temp_compare_node)
						break
					end
				else
					if temp_compare_node.getRightChild != nil
						temp_compare_node = temp_compare_node.getRightChild
					else
						temp_compare_node.setRightChild(node)
						node.setParent(temp_compare_node)
						break
					end
				end
			end
			@tree << node
		end
		@tree
	end

	def search(target)
		temp_compare_node = @root
		while temp_compare_node && target != temp_compare_node.getValue
			if target < temp_compare_node.getValue
				temp_compare_node = temp_compare_node.getLeftChild
			else
				temp_compare_node = temp_compare_node.getRightChild
			end
		end
		if temp_compare_node 
			print "----- "
			temp_compare_node.printNode
		else
			puts "Target not found."
		end
	end

	def breadth_first_search(target)
		curr = @root
		queue = []
		ind = -1
		while curr || queue.size > ind+1
			if curr 
				break if curr.getValue == target
				queue << curr.getLeftChild
				queue << curr.getRightChild
			end
			ind += 1
			curr = queue[ind]
		end
		if curr
			print "[BFS] "
			curr.printNode
		else
			puts "[BFS] Target not found."
		end
	end


#stack: [6,2,]
#curr = 1
	def depth_first_search(target)
		curr = @root
		stack = []
		loop do
			if curr
				break if curr.getValue == target
				stack << curr.getRightChild if curr.getRightChild
				if curr.getLeftChild 
					curr = curr.getLeftChild
				else
					break if stack.empty?
					curr = stack.pop
				end
			end
		end
		
		if curr.getValue == target
			print "[Dep] "
			curr.printNode
		else
			puts "[dfs] Target not found."
		end
	end

	def dfs_rec(target,current_compare=@root)
		return if current_compare == nil
		if current_compare.getValue == target
			print "[Rec] "
			current_compare.printNode
			return true
		end

		return if current_compare.getLeftChild == nil && current_compare.getRightChild == nil
		if current_compare.getLeftChild != nil
			dfs_rec(target,current_compare.getLeftChild)
		end
		dfs_rec(target, current_compare.getRightChild)
	end

	def printTree()
		@tree.each do |i|
			puts "#{i.getValue}, parent: #{i.getParent.getValue if i.getParent}, left: #{i.getLeftChild.getValue if i.getLeftChild}, right: #{i.getRightChild.getValue if i.getRightChild}"
		end
	end
end  

b = BTree.new
b.build_tree([5,2,6,8,9,6,8,2,6,3,5,1,4,2,7,1,8])
puts "Tree: "
b.printTree
puts
b.search(4)
b.breadth_first_search(4)
b.depth_first_search(4)
b.dfs_rec(4)
puts
b.search(5)
b.breadth_first_search(5)
b.depth_first_search(5)
b.dfs_rec(5)
puts
b.search(7)
b.breadth_first_search(7)
b.depth_first_search(7)
b.dfs_rec(7)
puts
b.search(13)
b.breadth_first_search(13)
b.depth_first_search(13)
b.dfs_rec(13)

