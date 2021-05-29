require 'yaml'
require 'base64'

# hangman game serialization
module HangmanSerialize
  SAVES_DIR = '../savegames'.freeze
  MAX_SAVES = 10

  def save_game
    clear_saves # only keep MAX_SAVES number of saves files

    data = {}
    instance_variables.each do |var|
      data[var.to_s] = instance_variable_get(var) unless var == :@wordlist
    end

    Dir.mkdir(SAVES_DIR) unless Dir.exist?(SAVES_DIR)

    filename = Time.now.strftime("#{SAVES_DIR}/hangman-%Y-%m-%d_%H-%M-%S.save")
    File.open(filename, 'w') { |file| file << encode(data.to_yaml) }

    puts "The game has been successfully saved at #{filename}.\n\n"
  end

  def load_game
    if saves.empty?
      puts "\n\e[0;31;49mNo saved games were found.\e[0m\n\n"
    else
      index    = load_input(saves)
      filename = saves[index]
      deserialize(filename)
      puts "\n#{filename} has been successfully loaded.\n\n"
    end
  end

  private

  def saves
    Dir.exist?(SAVES_DIR) ? Dir.children(SAVES_DIR).sort : []
  end

  def deserialize(filename)
    content = File.read("#{SAVES_DIR}/#{filename}")
    YAML.safe_load(decode(content)).each { |k, v| instance_variable_set(k, v) }
  end

  def encode(string)
    Base64.encode64(string)
  end

  def decode(string)
    Base64.decode64(string)
  end

  def clear_saves
    savegames = saves
    (savegames.length - MAX_SAVES + 1).times do
      File.delete(File.realpath("#{SAVES_DIR}/#{savegames.shift}"))
    end
  end
end
