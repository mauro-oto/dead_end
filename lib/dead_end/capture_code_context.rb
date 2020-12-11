# frozen_string_literal: true

module DeadEnd

  # Given a block, this method will capture surrounding
  # code to give the user more context for the location of
  # the problem.
  #
  # Return is an array of CodeLines to be rendered.
  #
  # Surrounding code is captured regardless of visible state
  #
  #   puts block.to_s # => "def bark"
  #
  #   context = CaptureCodeContext.new(
  #     blocks: block,
  #     code_lines: code_lines
  #   )
  #
  #   puts context.call.join
  #   # =>
  #     class Dog
  #       def bark
  #     end
  #
  class CaptureCodeContext
    attr_reader :code_lines

    def initialize(blocks: , code_lines:)
      @blocks = Array(blocks)
      @code_lines = code_lines
      @visible_lines = @blocks.map(&:visible_lines).flatten
      @lines_to_output = @visible_lines.dup
    end

    def call
      @blocks.each do |block|
        capture_last_end_same_indent(block)
        capture_before_after_kws(block)
        capture_falling_indent(block)
      end

      @lines_to_output.select!(&:not_empty?)
      @lines_to_output.select!(&:not_comment?)
      @lines_to_output.uniq!
      @lines_to_output.sort!

      return @lines_to_output
    end

    def capture_falling_indent(block)
      AroundBlockScan.new(
        block: block,
        code_lines: @code_lines,
      ).on_falling_indent do |line|
        @lines_to_output << line
      end
    end

    def capture_before_after_kws(block)
      around_lines = AroundBlockScan.new(code_lines: @code_lines, block: block)
        .start_at_next_line
        .capture_neighbor_context

      around_lines -= block.lines

      @lines_to_output.concat(around_lines)
    end

    def capture_last_end_same_indent(block)
      start_index = block.visible_lines.first.index
      lines = @code_lines[start_index..block.lines.last.index]
      end_lines = lines.select {|line| line.indent == block.current_indent && (line.is_end? || line.is_kw?) }

      # end_lines.each do |line|
      #   end_index = line.index
      #   lines = @code_lines[0..end_index].reverse
      #   stop_next = false
      #   lines.take_while
      # end

      @lines_to_output.concat(end_lines)
    end
  end
end
