import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lesson-form" (from the HTML data-controller attribute)
export default class extends Controller {
  
  // This method is linked to the data-action="change->lesson-form#updateSubjectOptions" attribute
  updateSubjectOptions(event) {
    // Get the ID of the student that was just selected
    const studentId = event.target.value
    
    // Find the Turbo Frame element that wraps the subject dropdown
    const turboFrame = document.getElementById("lesson_subject_field")
    
    // Safety check to ensure the frame exists
    if (!turboFrame) {
      console.error("Turbo Frame with ID 'lesson_subject_field' not found.")
      return
    }

    // Construct the URL to call the Rails controller action
    // This will hit the /lessons/update_subjects route you defined
    const url = `/lessons/update_subjects?student_id=${studentId}`
    
    // Setting the 'src' attribute on the turbo-frame 
    // triggers an AJAX request to the URL. Turbo then takes the response 
    // (the rendered partial) and replaces the frame's content.
    turboFrame.src = url
  }
}