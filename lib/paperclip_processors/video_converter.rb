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
#ffmpeg -i INPUT -s 320x240 -r 30000/1001 -b 200k -bt 240k -vcodec libx264 -coder 0 -bf 0 -refs 1 -flags2 -wpred-dct8x8 -level 30 -maxrate 10M -bufsize 10M -acodec libfaac -ac 2 -ar 48000 -ab 192k OUTPUT.mp4

      cmd = %Q[ -i "#{File.expand_path(file.path)}" -f mov -b 720k -r 23.976 -aspect 16:9 -s 480x320 -acodec libfaac -ab 256k -ar 44100 -ac 2 -y ]
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
