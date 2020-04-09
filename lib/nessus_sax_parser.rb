# require "nessus_sax_parser/version"
require "nokogiri"
module NessusSaxParser
    class MyDocument < Nokogiri::XML::SAX::Document
      attr_accessor :targets, :plugin_set, :nessus_result, :not_complete

      def initialize()
          self.nessus_result = Hash.new
          self.not_complete = Array.new

          @target_flag = false
          @plugin_set_flag = false
          
          @output_flag = false
          @end_flag = false

          @get_after = false
          
          self.targets = ''
          self.plugin_set = ''
      end

      # check the element name here and create an active record object if appropriate
      def start_element(name, attrs)
          @content = ''

        # getting attributes inside ReportHost tag
        if name == 'ReportHost'
            @host_ip = Hash[attrs]['name']
            self.nessus_result.store @host_ip, Hash.new unless @host_ip.empty?

        end

        # getting attributes inside Reportitem tag
        if name == 'ReportItem'
            @nessus_id = Hash[attrs]['pluginID']
            @port = Hash[attrs]['port']
        end

        # getting attributes inside the tag tag
        if name == 'tag'
            
            if Hash[attrs]['name'] == "HOST_END"
                @end_flag = true
            end
        end

      end
     
     # check the tag name and possibly use the characters you've collected
     # and save your activerecord object now
      def end_element(name)
        if name == 'preference'
            if @target_flag
                self.targets = @content
                self.targets = self.targets.split(",")
                @target_flag = false
            end
            if @plugin_set_flag
                self.plugin_set = @content
                self.plugin_set = self.plugin_set.split(";")
                @plugin_set_flag = false
            end
        end

        if name == 'plugin_output'
            @output = @content.gsub("\n\n\n","\n")
        end

        if name == 'ReportItem'

            #save in nessus_result Hash the events occurred in a host_ip at the end of each ReportItem
            self.nessus_result[@host_ip].store @port.to_i, Hash.new unless self.nessus_result[@host_ip].has_key? @port.to_i
            self.nessus_result[@host_ip][@port.to_i].store @nessus_id.to_i, Array.new unless self.nessus_result[@host_ip][@port.to_i].has_key? @nessus_id.to_i
            self.nessus_result[@host_ip][@port.to_i][@nessus_id.to_i] << (!@output.empty? ? @output.gsub("\n\n\n","\n") : false)

            #clean the variables
            @output = ''
            @nessus_id = ''
            @port = ''

        end

        if name == 'ReportHost'
            if !@end_flag
                @not_complete << @host_ip
            end
            @host_ip = ''
            @end_flag = false
        end

        if name == 'name'
            if @content == 'TARGET'
                @target_flag = true
            end
            if @content == 'plugin_set'
                @plugin_set_flag = true
            end
        end

      end

      # save the characters that appear here and possibly use them in the current tag object
      def characters(string)
        @content << string if @content
      end

    end

end
