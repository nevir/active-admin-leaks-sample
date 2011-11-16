class ApplicationController < ActionController::Base
  protect_from_forgery

  def home
    # Ensure that the user model is loaded
    current_admin_user

    GC.start

    # Top objects by class
    class_counts = Hash.new(0)
    ObjectSpace.each_object { |o| class_counts[o.class] += 1 }
    @top_by_class = class_counts.sort_by { |k,c| -c }

    # Redefined classes
    counts_by_name = Hash.new(0)
    ObjectSpace.each_object(Class) { |o| counts_by_name[o.name] += 1 }
    @redefined_classes = counts_by_name.sort_by { |n,c| -c }.select { |p| p[0].present? }
  end
end
