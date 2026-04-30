import os
import json
import csv
import datetime
from typing import List, Dict, Union

# Placeholder for PDF and LMS attendance handling libraries
# import PyPDF2
# import some_lms_library

class EvidenceCollectionPipeline:
    def __init__(self, evidence_repo_path: str):
        self.evidence_repo_path = evidence_repo_path

    def ingest_evidence(self, file_path: str) -> Dict:
        """
        Ingest evidence from various file types: JSON, CSV, PDF, LMS exports.
        Returns a dictionary with extracted data and metadata.
        """
        ext = os.path.splitext(file_path)[1].lower()
        if ext == '.json':
            return self._ingest_json(file_path)
        elif ext == '.csv':
            return self._ingest_csv(file_path)
        elif ext == '.pdf':
            return self._ingest_pdf(file_path)
        # elif ext == '.lms':  # Placeholder for LMS export format
        #     return self._ingest_lms(file_path)
        else:
            raise ValueError(f"Unsupported evidence file format: {ext}")

    def _ingest_json(self, file_path: str) -> Dict:
        with open(file_path, 'r') as f:
            data = json.load(f)
        metadata = self._extract_metadata(file_path)
        return {'data': data, 'metadata': metadata}

    def _ingest_csv(self, file_path: str) -> Dict:
        data = []
        with open(file_path, 'r') as f:
            reader = csv.DictReader(f)
            for row in reader:
                data.append(row)
        metadata = self._extract_metadata(file_path)
        return {'data': data, 'metadata': metadata}

    def _ingest_pdf(self, file_path: str) -> Dict:
        # Placeholder implementation
        # Use PyPDF2 or similar to extract text and metadata from PDF
        text_content = f"Extracted text from {file_path} (placeholder)"
        metadata = self._extract_metadata(file_path)
        return {'data': text_content, 'metadata': metadata}

    def _extract_metadata(self, file_path: str) -> Dict:
        # Example metadata extraction: file creation and modification time
        stat = os.stat(file_path)
        created = datetime.datetime.fromtimestamp(stat.st_ctime)
        modified = datetime.datetime.fromtimestamp(stat.st_mtime)
        # Additional metadata can be extracted as needed
        return {
            'file_path': file_path,
            'created': created.isoformat(),
            'modified': modified.isoformat()
        }

    def validate_metadata(self, metadata: Dict, expected_timeline: Dict[str, str]) -> bool:
        """
        Validate metadata timestamps against expected remediation timeline.
        expected_timeline: dict with 'start' and 'end' ISO datetime strings
        """
        created = datetime.datetime.fromisoformat(metadata.get('created'))
        modified = datetime.datetime.fromisoformat(metadata.get('modified'))
        start = datetime.datetime.fromisoformat(expected_timeline.get('start'))
        end = datetime.datetime.fromisoformat(expected_timeline.get('end'))

        if not (start <= created <= end):
            return False
        if not (start <= modified <= end):
            return False
        return True

    def integrate_with_repository(self, evidence_data: Dict) -> bool:
        """
        Placeholder for integration with centralized evidence repository.
        This could be API calls or direct file storage.
        """
        # For now, simulate storage by writing to a local directory
        try:
            file_name = os.path.basename(evidence_data['metadata']['file_path'])
            dest_path = os.path.join(self.evidence_repo_path, file_name)
            with open(dest_path, 'w', encoding='utf-8') as f:
                if isinstance(evidence_data['data'], str):
                    f.write(evidence_data['data'])
                else:
                    json.dump(evidence_data['data'], f, indent=2)
            return True
        except Exception as e:
            print(f"Failed to store evidence: {e}")
            return False

    def enforce_retention_policy(self, retention_days: int) -> None:
        """
        Remove evidence files older than retention_days from the repository.
        """
        now = datetime.datetime.now()
        for filename in os.listdir(self.evidence_repo_path):
            file_path = os.path.join(self.evidence_repo_path, filename)
            if os.path.isfile(file_path):
                stat = os.stat(file_path)
                modified = datetime.datetime.fromtimestamp(stat.st_mtime)
                age_days = (now - modified).days
                if age_days > retention_days:
                    os.remove(file_path)
                    print(f"Removed old evidence file: {filename}")

    def categorize_evidence(self, evidence_data: Dict) -> str:
        """
        Simple categorization based on file name or metadata (can be extended).
        """
        file_path = evidence_data['metadata']['file_path']
        if 'patch' in file_path.lower() or 'inventory' in file_path.lower():
            return 'patching_logs'
        elif 'waf' in file_path.lower():
            return 'waf_configurations'
        elif 'vendor' in file_path.lower() or 'audit' in file_path.lower():
            return 'vendor_audit_reports'
        elif 'access' in file_path.lower():
            return 'access_control_logs'
        elif 'vulnerability' in file_path.lower() or 'scan' in file_path.lower():
            return 'vulnerability_scans'
        elif 'training' in file_path.lower() or 'attendance' in file_path.lower():
            return 'training_records'
        else:
            return 'other'

    def correlate_evidence(self, evidence_list: List[Dict]) -> Dict[str, List[Dict]]:
        """
        Correlate evidence by category into a dictionary.
        """
        categorized = {}
        for evidence in evidence_list:
            category = self.categorize_evidence(evidence)
            categorized.setdefault(category, []).append(evidence)
        return categorized


# Example usage (to be removed or adapted in integration):
# pipeline = EvidenceCollectionPipeline('/path/to/evidence_repo')
# evidence = pipeline.ingest_evidence('/path/to/evidence.json')
# valid = pipeline.validate_metadata(evidence['metadata'], {'start': '2026-04-01T00:00:00', 'end': '2026-06-30T23:59:59'})
# if valid:
#     pipeline.integrate_with_repository(evidence)
# pipeline.enforce_retention_policy(90)
