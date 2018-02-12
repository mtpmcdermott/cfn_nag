class TemplateDiscovery
  def discover_templates(input_json_path)
    if ::File.directory? input_json_path
      templates = find_templates_in_directory(directory: input_json_path)
    elsif ::File.file? input_json_path
      if input_json_path.is_a? File
        templates = [input_json_path.path]
      else
        templates = [input_json_path]
      end
    else
      fail "#{input_json_path} is not a proper path"
    end
    templates
  end

  private

  def find_templates_in_directory(directory:,
                                  cfn_extensions: %w(yaml yml template))

    templates = []
    cfn_extensions.each do |cfn_extension|
      templates += Dir[File.join(directory, "**/*.#{cfn_extension}")]
    end
    templates
  end
end
