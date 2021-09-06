class PolyTreeNode

    attr_reader :value, :children
    attr_accessor :parent

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent_node)
        @parent.children.delete(self) if !@parent.nil?
        @parent = parent_node
        return if parent_node.nil?
        @parent.children << self if !@parent.children.include?(self)
    end

    def add_child(child_node)
        @children << child_node
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "node does not contain this child" if !children.include?(child_node)
        @children.delete(child_node)
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if @value == target_value
        @children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self] # start queue with self
        until queue.empty?
            node = queue.shift
            return node if node.value == target_value
            ( queue += node.children ) if !node.children.nil?
        end
        nil 
    end

end