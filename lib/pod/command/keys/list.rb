require 'keyring_liberator'

module Pod
  class Command
    class Keys

      class List < Keys
        self.summary = "A key value store for environment settings in Cocoa Apps."

        self.description = <<-DESC
          Longer description of cocoapods-keys.
        DESC

        def run

            # List all settings for current app
            this_keyring = CocoaPodsKeys::KeyringLiberator.get_keyring(Dir.getwd)
            if this_keyring
              display_keyring(this_keyring, true)
            end

            puts "-"

            # List all known bundle ids

            all_keyrings = CocoaPodsKeys::KeyringLiberator.get_all_keyrings()
            all_keyrings.each do |keyring|
              display_keyring(keyring) if keyring != this_keyring
            end
        end

        def display_keyring(keyring, display_values=false)
          puts "keyring: #{keyring.name}"
          keyring.keychain_data.each do |key, value|
            puts "\t#{key}: " + (display_values ? value : '*****')
          end
        end
      end
    end
  end
end
