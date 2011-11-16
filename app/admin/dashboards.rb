ActiveAdmin::Dashboards.build do

  section 'Top objects by class', priority: 1 do
    GC.start

    class_counts = Hash.new(0)
    ObjectSpace.each_object { |o| class_counts[o.class] += 1 }
    sorted_counts = class_counts.sort_by { |k,c| -c }

    table do
      sorted_counts[0...25].each do |klass, count|
        tr do
          td(style: 'text-align: right') { klass.name || klass.inspect }
          td { count.to_s }
        end
      end
    end
  end

  section 'Top ActiveAdmin objects by class', priority: 2 do
    class_counts = Hash.new(0)
    ObjectSpace.each_object do |object|
      if object.class.name.present? && object.class.name.start_with?('ActiveAdmin')
        class_counts[object.class.name] += 1
      end
    end
    sorted_counts = class_counts.sort_by { |k,c| -c }

    table do
      sorted_counts[0...25].each do |class_name, count|
        tr do
          td(style: 'text-align: right') { class_name }
          td { count.to_s }
        end
      end
    end
  end

  section 'Redefined classes', priority: 3 do
    counts_by_name = Hash.new(0)
    ObjectSpace.each_object(Class) { |o| counts_by_name[o.name] += 1 }
    sorted_counts = counts_by_name.sort_by { |n,c| -c }.select { |p| p[0].present? }

    table do
      sorted_counts.select { |k,c| c > 1}.each do |class_name, count|
        tr do
          td(style: 'text-align: right') { class_name }
          td { count.to_s }
        end
      end
    end
  end

end
