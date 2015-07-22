module DeviseHelper
  def devise_error_messages!
    html = <<-HTML
      <div class="bs-callout bs-callout-warning">
      <h4>#{flash[:alert]}</h4>
    </div>
    HTML

    html.html_safe
  end
end