defmodule Voting.UploaderTest do
  use ExUnit.Case, async: true
  use Mimic

  alias Voting.Uploader

  describe "run/1" do
    test "returns ok when file size is valid and upload succeded" do
      expect(ExAws, :request, fn _ -> {:ok, %{status_code: 200}} end)
      upload = %{filename: "file.jpg", content_type: "image/jpeg", path: "/path-to-file"}

      assert {:ok, url} = Uploader.run(upload)
      assert String.starts_with?(url, "https://capsulemaglev-public.s3.amazonaws.com/")
      assert String.ends_with?(url, ".jpg")
    end

    test "returns ok when file size is invalid" do
      # Mimic garante que modulo não seja chamado
      reject(&ExAws.request/1)

      upload = %{
        filename: "file.jpg",
        content_type: "image/jpeg",
        path: "/users/local/images/large_logo.jpg"
      }

      assert {:error, :file_too_large} = Uploader.run(upload)
    end

    test "returns error when upload failed" do
      expect(ExAws, :request, fn _ -> {:error, %{status_code: 500}} end)
      upload = %{filename: "file.jpg", content_type: "image/jpeg", path: "/path-to-file"}

      assert {:error, :upload_error} = Uploader.run(upload)
    end
  end
end
