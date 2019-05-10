# See the Pagy documentation: https://ddnexus.github.io/pagy/extras/trim
# encoding: utf-8
# frozen_string_literal: true

class Pagy

  module Frontend

    TRIM = true   # boolean used by *_js helpers

    alias_method :pagy_link_proc_without_trim, :pagy_link_proc
    def pagy_link_proc_with_trim(pagy, link_extra='')
      link_proc  = pagy_link_proc_without_trim(pagy, link_extra)
      page_param = pagy.vars[:page_param]
      lambda do |n, text=n, extra=''|
        link = link_proc.call(n, text, extra)
        n == 1 ? link.sub(/[?&]#{page_param}=1(?![&])|\b(?<=[?&])#{page_param}=1&/, '') : link
      end
    end
    alias_method :pagy_link_proc, :pagy_link_proc_with_trim

  end
end
