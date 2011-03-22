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
      @mp4Options = " -y -acodec libfaac -ab 128k -f mp4 -vcodec libx264 -vpre fast -crf 22 -threads 2 "
      @ogvOptions = " -y -b 1500k -vcodec libtheora -f ogg -acodec libvorbis -ab 160000 -g 30 -s 640x360 "
      @webmOptions = " -y -threads 3 -f webm -vcodec libvpx -deinterlace -g 120 -level 216 -profile 0 -qmax 42 -qmin 10 -rc_buf_aggressivity 0.95 -vb 2M -acodec libvorbis -aq 90 -ac 2 "
      if @format == 'mp4'
        @options = @mp4Options
      elsif @format == 'ogv'
        @options = @ogvOptions
      elsif @format == 'webm'
        @options = @webmOptions
      end
      cmd = %Q[ -i "#{File.expand_path(file.path)}" ]
      cmd << @options
      cmd << %Q["#{File.expand_path(dst.path)}"]

      begin
        success = Paperclip.run('ffmpeg', cmd)
      rescue PaperclipCommandLineError
        raise PaperclipError, "There was an error transcoding the video:  #{@basename}" if whiny
      end
      dst
    end
  end
end
