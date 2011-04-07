module Paperclip
  class VideoConverter < Processor

    attr_accessor :format, :geometry, :whiny

    def initialize(file, options = {}, attachment = nil)
      super
      @format = options[:format] || 'mp4'
      @whiny = options[:whiny].nil? ? true : options[:whiny]
      @basename = File.basename(file.path, File.extname(file.path))
    end

    def make
      dst = Tempfile.new([ @basename, @format ].compact.join("."))
      dst.binmode

      #TODO: use -vpre slow for production?
      @mp4Options = " -y -acodec libfaac -ab 128k -f mp4 -vcodec libx264 -vpre fast -crf 22 -threads 2 -s 640x360 "
      @ogvOptions = " -v 8 --aspect 16:9 --max_size 640x320 --croptop --cropbottom --cropleft --cropright "
      @webmOptions = " -y -threads 3 -f webm -vcodec libvpx -deinterlace -g 120 -level 216 -profile 0 -qmax 42 -qmin 10 -rc_buf_aggressivity 0.95 -vb 2M -acodec libvorbis -aq 90 -ac 2 -s 640x360 "
      if @format == 'mp4'
        @options = @mp4Options
        cmd = 'ffmpeg'
        opt = " -i "
      elsif @format == 'ogv'
        @options = @ogvOptions
        cmd = 'ffmpeg2theora'
        opt = ""
      elsif @format == 'webm'
        @options = @webmOptions
        cmd = 'ffmpeg'
        opt  = " -i "
      end
      opt << %Q["#{File.expand_path(file.path)}"]
      opt << @options
      opt << %Q["#{File.expand_path(dst.path)}"]

      begin
          success = Paperclip.run(cmd, opt)
      rescue PaperclipCommandLineError
        raise PaperclipError, "There was an error transcoding the video:  #{@basename}" if whiny
      end
      dst
    end
  end
end
