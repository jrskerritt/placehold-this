require 'guard/plugin'
require 'guard/watcher'
require './image_monitor'

module ::Guard
  class Images < ::Guard::Plugin
    def initialize(options = {})
      @monitor = ImageMonitor.instance
      super
    end

    def name
      "app"
    end

    def run_all
      paths = Watcher.match_files(self, Dir.glob('{,**/}*{,.*}').uniq)
      additions = paths - @monitor.image_paths
      removals = @monitor.image_paths - paths
      @monitor.image_paths = paths
      run_on_additions(additions)
      run_on_removals(removals)
    end

    def run_on_additions(paths)
      paths.each { |path| @monitor.add_image(path) }
    end

    def run_on_removals(paths)
      paths.each { |path| @monitor.remove_image(path) }
    end
  end
end

guard :images do
  watch(%r{images/([^/]+/)?([^/]*\.(jpg|jpeg|gif|png|tiff|tif|bmp))})
end