module ApplicationHelper
	def textarea_newlines(content)
		content.gsub!(/\r\n?/, "\n");
		return simple_format(content)
	end
end
