# -*- encoding: utf-8 -*-

require_relative 'base'

module WebgenBibtex
  class Tag
    module BibItem
      extend WebgenBibtex::Tag::Base

      def self.call(tag, _, context)
        _, proc = make_objects(tag, context)
        proc.render(:bibliography,
                    id: context[:config]['tag.bibliography.key'])
      end
    end
  end
end
