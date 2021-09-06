require_relative 'poly_tree_node.rb'

class KnightPathFinder
    
    attr_reader :root_node
    attr_accessor :considered_positions

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [ pos ] 
        build_move_tree
    end

    def valid_moves(pos)
        row, col = pos
        return false if !(0...8).include?(row) || !(0...8).include?(col)
        return true
    end

    def new_move_positions(pos)
        row, col = pos
        positions = []

        moves = [ [2, 1], [2, -1], [-2, 1], [-2, -1], 
                    [1, 2], [1, -2], [-1, 2], [-1, -2] ]

        moves.each do |move|
            new_pos = [ row + move[0], col + move[1] ]
            positions << new_pos if ( valid_moves(new_pos) && !@considered_positions.include?(new_pos) )
        end

        @considered_positions += positions
        return positions
    end

    def build_move_tree

        queue = [ @root_node ]
        until queue.empty?
            parent = queue.shift
            childs = new_move_positions(parent.value)
            childs.each do |child|
                child_node = PolyTreeNode.new(child)
                parent.add_child(child_node)
                queue << child_node
            end
        end
    end

    def find_path(end_pos)
        queue = [ root_node ] # start queue with self
        until queue.empty?
            node = queue.shift
            return trace_path_back(node) if node.value == end_pos
            ( queue += node.children ) if !node.children.nil?
        end
        nil
    end

    def trace_path_back(node)
        path = []
        until node.parent.nil?
            path << node.value
            node = node.parent
        end
        path << @root_node.value
        path.reverse
    end

end