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
#-i /yourfile.mov -y -f mp4 -vcodec libx264 -crf 28 -threads 0 -flags +loop -cmp +chroma -deblockalpha -1 -deblockbeta -1 -refs 3 -bf 3 -coder 1 -me_method hex -me_range 18 -subq 7 -partitions +parti4x4+parti8x8+partp8x8+partb8x8 -g 320 -keyint_min 25 -level 41 -qmin 10 -qmax 51 -qcomp 0.7 -trellis 1 -sc_threshold 40 -i_qfactor 0.71 -flags2 +mixed_refs+dct8x8+wpred+bpyramid -padcolor 000000 -padtop 0 -padbottom 0 -padleft 0 -padright 0 -acodec libfaac -ab 80kb -ar 48000 -ac 2 outputfile.mp4

      @mp4Options = " -y -acodec libfaac -ab 128k -f mp4 -vcodec libx264 -vpre fast -crf 22 -threads 2 "
      cmd = %Q[ -i "#{File.expand_path(file.path)}" -y -acodec libfaac -ab 128k -f mp4 -vcodec libx264 -vpre fast -crf 22 -threads 2  ]
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
