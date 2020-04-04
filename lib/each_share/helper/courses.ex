defmodule EachShare.Helper.Courses do
  def get_each_couses() do
    [
      "BIOTECNOLOGIA",
      "EDUCAÇÃO FÍSICA E SAÚDE",
      "CIÊNCIAS DA NATUREZA",
      "GERONTOLOGIA",
      "GESTÃO AMBIENTAL",
      "GESTÃO DE POLÍTICAS PÚBLICAS",
      "LAZER E TURISMO",
      "MARKETING",
      "OBSTETRÍCIA",
      "SISTEMAS DE INFORMAÇÃO",
      "TÊXTIL E MODA"
    ]
    |> Enum.map(fn curso -> String.downcase curso end)
  end

  def create_courses_folders() do
    get_each_couses()
    |> Enum.map(fn curso -> EachShare.Folder.create_folder %{"name" => curso, "type" => "course"} end)
  end

  def get_semesters_map() do
    1..8
    |> Enum.map(fn n -> %{"name" => "##{n} semestre"} end)
  end

  def create_courses_with_semesters() do
    create_courses_folders()

    1..10
    |> Enum.each(fn folder_id ->
      for semester <- get_semesters_map(),
        do: EachShare.Folder.add_sub_folder(
          %{"id" => folder_id, "child_name" => semester["name"]}
        )
    end)
  end
end
