module Paperclip
  class Attachment
    private
      def solidify_style_definitions
        @styles.each do |name, args|
          @styles[name][:geometry] = @styles[name][:geometry].call(instance) if @styles[name][:geometry].respond_to?(:call)
          @styles[name][:processors] = @styles[name][:processors].call(instance) if @styles[name][:processors].respond_to?(:call)
        end
      end
  end
end